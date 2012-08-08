Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Sz2zu-00038x-HU
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:56:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sz2zs-0002oY-GY
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:56:14 +0000
Message-ID: <50223785.8040200@cn.fujitsu.com>
Date: Wed, 08 Aug 2012 17:55:17 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <1343925295-1884-1-git-send-email-xu.simon@oracle.com>
	<502223B6.2070608@cn.fujitsu.com> <502228E3.9010802@oracle.com>
In-Reply-To: <502228E3.9010802@oracle.com>
Subject: Re: [LTP] [PATCH 1/1] fix container_ftp.pl
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3798875821948144877=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3798875821948144877==
Content-Type: multipart/alternative;
	boundary="------------030302040100040202030905"

This is a multi-part message in MIME format.
--------------030302040100040202030905
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

On 08/08/2012 04:52 PM, Simon Xu wrote:
> On 2012/8/8 16:30, DAN LI wrote:
>> On 08/03/2012 12:34 AM, Simon Xu wrote:
>>> container_ftp.pl has several problems:
>>>
>>> * ftp users can't cd to a temporary dir in /tmp
>>> * ftp->cwd($dir) will always fail
>>> * if we do 'chdir $dir', 'rmdir("$dir")' will fail
>>> * 'ftp->put' should be 'ftp->get'
>>>
>>> Signed-off-by: Simon Xu <xu.simon@oracle.com>
>>> ---
>>>   testcases/kernel/containers/netns/container_ftp.pl | 15 
>>> ++++++++-------
>>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/testcases/kernel/containers/netns/container_ftp.pl 
>>> b/testcases/kernel/containers/netns/container_ftp.pl
>>> index 89a35b5..98742f3 100644
>>> --- a/testcases/kernel/containers/netns/container_ftp.pl
>>> +++ b/testcases/kernel/containers/netns/container_ftp.pl
>>> @@ -23,6 +23,7 @@
>>>     use File::Temp 'tempdir';
>>>   use Net::FTP;
>>> +use File::Path;
>>>     if ($#ARGV == -1) {
>>>       print "usage: $0 host\n";
>>> @@ -35,7 +36,7 @@ my $i = 0;
>>>   my $kount = 51;
>>>   my $file="junkfile";
>>>   -my $tmpdir = defined($ENV{TMPDIR}) ? $ENV{TMPDIR} : "/tmp";
>>> +my $tmpdir = "/var/ftp";
>> hi, Simon
>>
>> I tested container_ftp.pl as follow:
>> ********************************************************
>> #./container_ftp.pl    knownhost_with_vsftpd
>> ********************************************************
>> and failed at "$ftp->cwd" either with this fix or without it.
>>
>> So,did i get the wrong way to test this script ,or,something wrong
>> still exists.
>
> Could you print the value of $dir before "$ftp->cwd"?  And try ftp 
> login as anonymous user, and see if you can cd to the value.
>
Thanks for your quick reply and sorry for my careless.
I try operations as you suggested,and find the problem that dir created 
for test is not available
for any user expect root.

So, now i test and confirm this fix works fine.

Thanks
DAN LI
> Thanks
> Simon
>
>>>     my $dir;
>>>   $dir = tempdir("container_ftp.XXXXXXX", DIR => $tmpdir);
>>> @@ -47,8 +48,7 @@ if (chmod(0777, $dir) == 0) {
>>>       push @ERRORS, "Failed to change mode for temporary directory: 
>>> $!\n";
>>>       printerr();
>>>   }
>>> -chdir $dir;
>>> -system("dd if=/dev/zero of=$file bs=512 count=10 > /dev/null 2>&1 ");
>>> +system("dd if=/dev/zero of=$dir/$file bs=512 count=10 > /dev/null 
>>> 2>&1 ");
>>>     while ( $i < $kount )
>>>   {
>>> @@ -61,13 +61,15 @@ while ( $i < $kount )
>>>           $ftp->quit if $newerr;
>>>           printerr() if $newerr;
>>>   -        $ftp->cwd($dir) or $newerr=1;
>>> +        $basedir = `basename "$dir"`;
>>> +        chomp $basedir;
>>> +        $ftp->cwd($basedir) or $newerr=1;
>>>           push @ERRORS, "Can't cd  $!\n" if $newerr;
>>>           $ftp->quit if $newerr;
>>>           printerr() if $newerr;
>>>             $newname = $file . "_" . $i ;
>>> -        $ftp->put($file,$newname) or $newerr=1;
>>> +        $ftp->get($file,$newname) or $newerr=1;
>>>           push @ERRORS, "Can't get file $file $!\n" if $newerr;
>>>           printerr() if $newerr;
>>>   @@ -82,6 +84,5 @@ sub printerr {
>>>   }
>>>     END {
>>> -    unlink("$dir/$file");
>>> -    rmdir("$dir");
>>> +    rmtree("$dir");
>>>   }
>>
>>
>
>



--------------030302040100040202030905
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset=ISO-8859-1

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 08/08/2012 04:52 PM, Simon Xu wrote:<br>
    </div>
    <blockquote cite="mid:502228E3.9010802@oracle.com" type="cite">On
      2012/8/8 16:30, DAN LI wrote:
      <br>
      <blockquote type="cite">On 08/03/2012 12:34 AM, Simon Xu wrote:
        <br>
        <blockquote type="cite">container_ftp.pl has several problems:
          <br>
          <br>
          * ftp users can't cd to a temporary dir in /tmp
          <br>
          * ftp-&gt;cwd($dir) will always fail
          <br>
          * if we do 'chdir $dir', 'rmdir("$dir")' will fail
          <br>
          * 'ftp-&gt;put' should be 'ftp-&gt;get'
          <br>
          <br>
          Signed-off-by: Simon Xu <a class="moz-txt-link-rfc2396E" href="mailto:xu.simon@oracle.com">&lt;xu.simon@oracle.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; testcases/kernel/containers/netns/container_ftp.pl | 15
          ++++++++-------
          <br>
          &nbsp; 1 file changed, 8 insertions(+), 7 deletions(-)
          <br>
          <br>
          diff --git
          a/testcases/kernel/containers/netns/container_ftp.pl
          b/testcases/kernel/containers/netns/container_ftp.pl
          <br>
          index 89a35b5..98742f3 100644
          <br>
          --- a/testcases/kernel/containers/netns/container_ftp.pl
          <br>
          +++ b/testcases/kernel/containers/netns/container_ftp.pl
          <br>
          @@ -23,6 +23,7 @@
          <br>
          &nbsp;&nbsp;&nbsp; use File::Temp 'tempdir';
          <br>
          &nbsp; use <a class="moz-txt-link-freetext" href="Net::FTP">Net::FTP</a>;
          <br>
          +use File::Path;
          <br>
          &nbsp;&nbsp;&nbsp; if ($#ARGV == -1) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print "usage: $0 host\n";
          <br>
          @@ -35,7 +36,7 @@ my $i = 0;
          <br>
          &nbsp; my $kount = 51;
          <br>
          &nbsp; my $file="junkfile";
          <br>
          &nbsp; -my $tmpdir = defined($ENV{TMPDIR}) ? $ENV{TMPDIR} : "/tmp";
          <br>
          +my $tmpdir = "/var/ftp";
          <br>
        </blockquote>
        hi, Simon
        <br>
        <br>
        I tested container_ftp.pl as follow:
        <br>
        ********************************************************
        <br>
        #./container_ftp.pl&nbsp;&nbsp;&nbsp; knownhost_with_vsftpd
        <br>
        ********************************************************
        <br>
        and failed at "$ftp-&gt;cwd" either with this fix or without it.
        <br>
        <br>
        So,did i get the wrong way to test this script ,or,something
        wrong
        <br>
        still exists.
        <br>
      </blockquote>
      <br>
      Could you print the value of $dir before "$ftp-&gt;cwd"?&nbsp; And try
      ftp login as anonymous user, and see if you can cd to the value.
      <br>
      <br>
    </blockquote>
    Thanks for your quick reply and sorry for my careless.<span
      style="color: rgb(0, 0, 0); font-family: arial; font-size: small;
      font-style: normal; font-variant: normal; font-weight: normal;
      letter-spacing: normal; line-height: 18px; orphans: 2; text-align:
      -webkit-auto; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-size-adjust:
      auto; -webkit-text-stroke-width: 0px; background-color: rgb(255,
      255, 255); display: inline !important; float: none; "></span><br>
    I try operations as you suggested,and find the problem that dir
    created for test is not available <br>
    for any user expect root.<br>
    <br>
    So, now i test and confirm this fix works fine.<br>
    <br>
    Thanks<br>
    DAN LI<br>
    <blockquote cite="mid:502228E3.9010802@oracle.com" type="cite">Thanks
      <br>
      Simon
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">&nbsp;&nbsp;&nbsp; my $dir;
          <br>
          &nbsp; $dir = tempdir("container_ftp.XXXXXXX", DIR =&gt; $tmpdir);
          <br>
          @@ -47,8 +48,7 @@ if (chmod(0777, $dir) == 0) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; push @ERRORS, "Failed to change mode for temporary
          directory: $!\n";
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printerr();
          <br>
          &nbsp; }
          <br>
          -chdir $dir;
          <br>
          -system("dd if=/dev/zero of=$file bs=512 count=10 &gt;
          /dev/null 2&gt;&amp;1 ");
          <br>
          +system("dd if=/dev/zero of=$dir/$file bs=512 count=10 &gt;
          /dev/null 2&gt;&amp;1 ");
          <br>
          &nbsp;&nbsp;&nbsp; while ( $i &lt; $kount )
          <br>
          &nbsp; {
          <br>
          @@ -61,13 +61,15 @@ while ( $i &lt; $kount )
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ftp-&gt;quit if $newerr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printerr() if $newerr;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ftp-&gt;cwd($dir) or $newerr=1;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $basedir = `basename "$dir"`;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chomp $basedir;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ftp-&gt;cwd($basedir) or $newerr=1;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; push @ERRORS, "Can't cd&nbsp; $!\n" if $newerr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ftp-&gt;quit if $newerr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printerr() if $newerr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $newname = $file . "_" . $i ;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ftp-&gt;put($file,$newname) or $newerr=1;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ftp-&gt;get($file,$newname) or $newerr=1;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; push @ERRORS, "Can't get file $file $!\n" if
          $newerr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printerr() if $newerr;
          <br>
          &nbsp; @@ -82,6 +84,5 @@ sub printerr {
          <br>
          &nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp; END {
          <br>
          -&nbsp;&nbsp;&nbsp; unlink("$dir/$file");
          <br>
          -&nbsp;&nbsp;&nbsp; rmdir("$dir");
          <br>
          +&nbsp;&nbsp;&nbsp; rmtree("$dir");
          <br>
          &nbsp; }
          <br>
        </blockquote>
        <br>
        <br>
      </blockquote>
      <br>
      <br>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------030302040100040202030905--


--===============3798875821948144877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============3798875821948144877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3798875821948144877==--

