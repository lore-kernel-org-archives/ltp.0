Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SUHDt-0006nO-M1
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 12:51:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SUHDs-0004vS-Lw
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 12:51:29 +0000
Message-ID: <4FB25100.7030505@cn.fujitsu.com>
Date: Tue, 15 May 2012 20:50:08 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1336655089-26941-1-git-send-email-marios.makris@gmail.com>
	<1336655089-26941-3-git-send-email-marios.makris@gmail.com>
	<4FB0B348.3020601@cn.fujitsu.com>
	<CAMYrgfQUi_LziMsMsAkSnQdYS6FAryf71dHx6CHX_z5xJDPQmg@mail.gmail.com>
	<4FB245C8.2040801@cn.fujitsu.com>
	<CAMYrgfQTx7hYF4MJr-FfxwjW_Ce+iVJON4eowdfoo97pB8YH2Q@mail.gmail.com>
In-Reply-To: <CAMYrgfQTx7hYF4MJr-FfxwjW_Ce+iVJON4eowdfoo97pB8YH2Q@mail.gmail.com>
Subject: Re: [LTP] [PATCH 3/3] Changed nconv variable from long to int in
 /lib/bytes_by_prefix.c
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Marioh mrs <marios.makris@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 05/15/2012 08:36 PM, Marioh mrs wrote:

>>
>> At least you can take a look at here ./testcases/kernel/fs/doio/iogen.c
>>
>> Thanks,
>> Wanlong Gao
>>
> 
> Hello again,
> 
> This file usages have been replaced in the 2nd patch:
> [PATCH 2/3] Renamed /lib/str_to_bytes.c and /include str_to bytes.h
> 
> Below i have pasted the diff from the patch only for that particular file
> from the contents of the patch as sent in the list.
> 
> Thanks again :)


Oh, sorry I missed.

Any other comments?


Thanks,
Wanlong Gao

> 
> 
> diff --git a/testcases/kernel/fs/doio/iogen.c b/testcases/kernel/fs/doio/iogen.c
> index 167edbd..f594007 100644
> --- a/testcases/kernel/fs/doio/iogen.c
> +++ b/testcases/kernel/fs/doio/iogen.c
> @@ -61,7 +61,7 @@
>  #include "libkern.h"
>  #endif
>  #include "doio.h"
> -#include "str_to_bytes.h"
> +#include "bytes_by_prefix.h"
>  #include "string_to_tokens.h"
>  #include "open_flags.h"
>  #include "random_range.h"
> @@ -1555,7 +1555,7 @@ parse_cmdline(int argc, char **argv, char *opts)
>           break;
> 
>       case 'r':
> -           if ((Rawmult = str_to_bytes(optarg)) == -1 ||
> +           if ((Rawmult = bytes_by_prefix(optarg)) == -1 ||
>                         Rawmult < 11 || Rawmult % BSIZE) {
>               fprintf(stderr, "iogen%s:  Illegal -r arg (%s).  Must
> be > 0 and multipe of BSIZE (%d)\n",
>                       TagName, optarg, BSIZE);
> @@ -1587,7 +1587,7 @@ parse_cmdline(int argc, char **argv, char *opts)
>           break;
> 
>       case 't':
> -           if ((Mintrans = str_to_bytes(optarg)) == -1) {
> +           if ((Mintrans = bytes_by_prefix(optarg)) == -1) {
>               fprintf(stderr, "iogen%s:  Illegal -t arg (%s):  Must
> have the form num[bkm]\n", TagName, optarg);
>               exit(1);
>           }
> @@ -1595,7 +1595,7 @@ parse_cmdline(int argc, char **argv, char *opts)
>           break;
> 
>       case 'T':
> -           if ((Maxtrans = str_to_bytes(optarg)) == -1) {
> +           if ((Maxtrans = bytes_by_prefix(optarg)) == -1) {
>               fprintf(stderr, "iogen%s:  Illegal -T arg (%s):  Must
> have the form num[bkm]\n", TagName, optarg);
>               exit(1);
>           }
> @@ -1740,7 +1740,7 @@ parse_cmdline(int argc, char **argv, char *opts)
> 
>           if ((cp = strchr(argv[optind], ':')) != NULL) {
>               *cp = '\0';
> -               if ((len = str_to_bytes(argv[optind])) == -1) {
> +               if ((len = bytes_by_prefix(argv[optind])) == -1) {
>                   fprintf(stderr,
>                           "iogen%s:  illegal file length (%s) for file %s\n",
>                           TagName, argv[optind], cp+1);



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
