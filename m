Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Sz20n-0008Gs-LL
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 08:53:05 +0000
Received: from rcsinet15.oracle.com ([148.87.113.117])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sz20j-0003oW-Pt
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 08:53:05 +0000
Message-ID: <502228E3.9010802@oracle.com>
Date: Wed, 08 Aug 2012 16:52:51 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1343925295-1884-1-git-send-email-xu.simon@oracle.com>
	<502223B6.2070608@cn.fujitsu.com>
In-Reply-To: <502223B6.2070608@cn.fujitsu.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 2012/8/8 16:30, DAN LI wrote:
> On 08/03/2012 12:34 AM, Simon Xu wrote:
>> container_ftp.pl has several problems:
>>
>> * ftp users can't cd to a temporary dir in /tmp
>> * ftp->cwd($dir) will always fail
>> * if we do 'chdir $dir', 'rmdir("$dir")' will fail
>> * 'ftp->put' should be 'ftp->get'
>>
>> Signed-off-by: Simon Xu <xu.simon@oracle.com>
>> ---
>>   testcases/kernel/containers/netns/container_ftp.pl | 15 
>> ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/netns/container_ftp.pl 
>> b/testcases/kernel/containers/netns/container_ftp.pl
>> index 89a35b5..98742f3 100644
>> --- a/testcases/kernel/containers/netns/container_ftp.pl
>> +++ b/testcases/kernel/containers/netns/container_ftp.pl
>> @@ -23,6 +23,7 @@
>>     use File::Temp 'tempdir';
>>   use Net::FTP;
>> +use File::Path;
>>     if ($#ARGV == -1) {
>>       print "usage: $0 host\n";
>> @@ -35,7 +36,7 @@ my $i = 0;
>>   my $kount = 51;
>>   my $file="junkfile";
>>   -my $tmpdir = defined($ENV{TMPDIR}) ? $ENV{TMPDIR} : "/tmp";
>> +my $tmpdir = "/var/ftp";
> hi, Simon
>
> I tested container_ftp.pl as follow:
> ********************************************************
> #./container_ftp.pl    knownhost_with_vsftpd
> ********************************************************
> and failed at "$ftp->cwd" either with this fix or without it.
>
> So,did i get the wrong way to test this script ,or,something wrong
> still exists.

Could you print the value of $dir before "$ftp->cwd"?  And try ftp login 
as anonymous user, and see if you can cd to the value.

Thanks
Simon

>>     my $dir;
>>   $dir = tempdir("container_ftp.XXXXXXX", DIR => $tmpdir);
>> @@ -47,8 +48,7 @@ if (chmod(0777, $dir) == 0) {
>>       push @ERRORS, "Failed to change mode for temporary directory: 
>> $!\n";
>>       printerr();
>>   }
>> -chdir $dir;
>> -system("dd if=/dev/zero of=$file bs=512 count=10 > /dev/null 2>&1 ");
>> +system("dd if=/dev/zero of=$dir/$file bs=512 count=10 > /dev/null 
>> 2>&1 ");
>>     while ( $i < $kount )
>>   {
>> @@ -61,13 +61,15 @@ while ( $i < $kount )
>>           $ftp->quit if $newerr;
>>           printerr() if $newerr;
>>   -        $ftp->cwd($dir) or $newerr=1;
>> +        $basedir = `basename "$dir"`;
>> +        chomp $basedir;
>> +        $ftp->cwd($basedir) or $newerr=1;
>>           push @ERRORS, "Can't cd  $!\n" if $newerr;
>>           $ftp->quit if $newerr;
>>           printerr() if $newerr;
>>             $newname = $file . "_" . $i ;
>> -        $ftp->put($file,$newname) or $newerr=1;
>> +        $ftp->get($file,$newname) or $newerr=1;
>>           push @ERRORS, "Can't get file $file $!\n" if $newerr;
>>           printerr() if $newerr;
>>   @@ -82,6 +84,5 @@ sub printerr {
>>   }
>>     END {
>> -    unlink("$dir/$file");
>> -    rmdir("$dir");
>> +    rmtree("$dir");
>>   }
>
>


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
