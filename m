Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Sz1gC-0008L5-0n
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 08:31:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sz1g7-0003uU-Vc
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 08:31:47 +0000
Message-ID: <502223B6.2070608@cn.fujitsu.com>
Date: Wed, 08 Aug 2012 16:30:46 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <1343925295-1884-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1343925295-1884-1-git-send-email-xu.simon@oracle.com>
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net, OEL-QA_WW@oracle.com

On 08/03/2012 12:34 AM, Simon Xu wrote:
> container_ftp.pl has several problems:
>
> * ftp users can't cd to a temporary dir in /tmp
> * ftp->cwd($dir) will always fail
> * if we do 'chdir $dir', 'rmdir("$dir")' will fail
> * 'ftp->put' should be 'ftp->get'
>
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>   testcases/kernel/containers/netns/container_ftp.pl | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/containers/netns/container_ftp.pl b/testcases/kernel/containers/netns/container_ftp.pl
> index 89a35b5..98742f3 100644
> --- a/testcases/kernel/containers/netns/container_ftp.pl
> +++ b/testcases/kernel/containers/netns/container_ftp.pl
> @@ -23,6 +23,7 @@
>   
>   use File::Temp 'tempdir';
>   use Net::FTP;
> +use File::Path;
>   
>   if ($#ARGV == -1) {
>   	print "usage: $0 host\n";
> @@ -35,7 +36,7 @@ my $i = 0;
>   my $kount = 51;
>   my $file="junkfile";
>   
> -my $tmpdir = defined($ENV{TMPDIR}) ? $ENV{TMPDIR} : "/tmp";
> +my $tmpdir = "/var/ftp";
hi, Simon

I tested container_ftp.pl as follow:
********************************************************
#./container_ftp.pl    knownhost_with_vsftpd
********************************************************
and failed at "$ftp->cwd" either with this fix or without it.

So,did i get the wrong way to test this script ,or,something wrong
still exists.
>   
>   my $dir;
>   $dir = tempdir("container_ftp.XXXXXXX", DIR => $tmpdir);
> @@ -47,8 +48,7 @@ if (chmod(0777, $dir) == 0) {
>   	push @ERRORS, "Failed to change mode for temporary directory: $!\n";
>   	printerr();
>   }
> -chdir $dir;
> -system("dd if=/dev/zero of=$file bs=512 count=10 > /dev/null 2>&1 ");
> +system("dd if=/dev/zero of=$dir/$file bs=512 count=10 > /dev/null 2>&1 ");
>   
>   while ( $i < $kount )
>   {
> @@ -61,13 +61,15 @@ while ( $i < $kount )
>           $ftp->quit if $newerr;
>           printerr() if $newerr;
>   
> -        $ftp->cwd($dir) or $newerr=1;
> +        $basedir = `basename "$dir"`;
> +        chomp $basedir;
> +        $ftp->cwd($basedir) or $newerr=1;
>           push @ERRORS, "Can't cd  $!\n" if $newerr;
>           $ftp->quit if $newerr;
>           printerr() if $newerr;
>   
>           $newname = $file . "_" . $i ;
> -        $ftp->put($file,$newname) or $newerr=1;
> +        $ftp->get($file,$newname) or $newerr=1;
>           push @ERRORS, "Can't get file $file $!\n" if $newerr;
>           printerr() if $newerr;
>   
> @@ -82,6 +84,5 @@ sub printerr {
>   }
>   
>   END {
> -	unlink("$dir/$file");
> -	rmdir("$dir");
> +	rmtree("$dir");
>   }



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
