Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <wangyong2009@cn.fujitsu.com>) id 1MT8dX-0002E4-38
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 06:15:39 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MT8dR-00056X-Qf
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 06:15:39 +0000
Message-ID: <4A655D3C.2040601@cn.fujitsu.com>
Date: Tue, 21 Jul 2009 14:16:28 +0800
From: Wang Yong <wangyong2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4A652E3C.20402@cn.fujitsu.com>
	<364299f40907202124u8cd7a14n6e331fc53648ca66@mail.gmail.com>
In-Reply-To: <364299f40907202124u8cd7a14n6e331fc53648ca66@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix failure of the utimes01 test
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>



Garrett Cooper wrote as:
> On Mon, Jul 20, 2009 at 7:55 PM, Wang Yong<wangyong2009@cn.fujitsu.com> wrote:
>   
>> This patch also fixed the path which we pass to setup_file(). If
>> progdir is not a absolute pathname of the working directory, the file
>> open will fail.
>>
>> This patch fixed the problem.
>>
>> Signed-off-by: WangYong <wangyong2009@cn.fujitsu.com>
>>
>> diff -Nurp a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
>> --- a/testcases/kernel/syscalls/utimes/utimes01.c       2009-07-21 08:51:05.000000000 +0800
>> +++ b/testcases/kernel/syscalls/utimes/utimes01.c       2009-07-21 08:55:01.000000000 +0800
>> @@ -138,7 +138,6 @@ void setup() {
>>  */
>>  static int opt_debug;
>>  static char *progname;
>> -static char *progdir;
>>
>>  enum test_type {
>>                NORMAL,
>> @@ -232,7 +231,7 @@ static int do_test(struct test_case *tc)
>>         struct stat st;
>>         uid_t old_uid;
>>
>> -        TEST(rc = setup_file(progdir, "test.file", fpath));
>> +        TEST(rc = setup_file(TESTDIR, "test.file", fpath));
>>         if (rc < 0)
>>                 return 1;
>>
>> @@ -339,8 +338,6 @@ int main(int ac, char **av) {
>>        progname = strchr(av[0], '/');
>>         progname = progname ? progname + 1 : av[0];
>>
>> -       progdir = strdup(av[0]);
>> -        progdir = dirname(progdir);
>>
>>         /* parse standard options */
>>         if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
>>     
>
> Wang,
>     Would you please verify this diff in your environment too? It does
> what your diff did, in addition to fixes a harmless warning with
> -Wnonnull:
>
> 1. Fix the utimes testcase so that it passes with the appropriate
> non-hardcoded directory, as provided by Wang Yong
> <wangyong2009@cn.fujitsu.com>
> 2. Fix a compiler warning by using an intermediary const char*
> variable, as casting alone was still causing compiler warnings in gcc
> 4.3.2.
>   
Hi,

I have verified this diff in my environment. Your patch is ok.  
Thank you for having fixed the warning.

> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: testcases/kernel/syscalls/utimes/utimes01.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/utimes/utimes01.c,v
> retrieving revision 1.2
> diff -u -r1.2 utimes01.c
> --- testcases/kernel/syscalls/utimes/utimes01.c 10 Jul 2009 10:14:59 -0000     1
> .2
> +++ testcases/kernel/syscalls/utimes/utimes01.c 21 Jul 2009 04:20:44 -0000
> @@ -138,7 +138,6 @@
>   */
>  static int opt_debug;
>  static char *progname;
> -static char *progdir;
>
>  enum test_type {
>                 NORMAL,
> @@ -232,7 +231,7 @@
>          struct stat st;
>          uid_t old_uid;
>
> -        TEST(rc = setup_file(progdir, "test.file", fpath));
> +        TEST(rc = setup_file(TESTDIR, "test.file", fpath));
>          if (rc < 0)
>                  return 1;
>
> @@ -257,9 +256,19 @@
>                  fpath[len - 1] = '\0';
>          }
>          errno = 0;
> -        if (tc->ttype == NO_FNAME)
> -                TEST(sys_ret = utimes(NULL, tv));
> -        else
> +        if (tc->ttype == NO_FNAME) {
> +                /**
> +                 * Note (garrcoop):
> +                 *
> +                 * If you do NULL directly, then gcc [4.3] will complain when
> +                 * one specifies -Wnonnull in CPPFLAGS. This is a negative
> +                 * test, but let's not allow the compiler to complain about
> +                 * something trivial like this.
> +                 **/
> +                const char *dummy = NULL;
> +                TEST(sys_ret = utimes(dummy, tv));
> +        }
> +       else
>                  TEST(sys_ret = utimes(fpath, tv));
>          sys_errno = errno;
>          if (tc->ttype == FILE_NOT_EXIST)
> @@ -339,9 +348,6 @@
>         progname = strchr(av[0], '/');
>          progname = progname ? progname + 1 : av[0];
>
> -       progdir = strdup(av[0]);
> -        progdir = dirname(progdir);
> -
>          /* parse standard options */
>          if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL)
> {
>               tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
>
>
>
>   

-- 
Wang Yong
Development Dept.I
Nanjing Fujitsu Nanda Software Tech. Co., Ltd.(FNST)
8/F.,Civil Defense Building, No. 189 Guangzhou Rd,
Nanjing, 210029, China
TEL: +86+25-86630566-837
COINS: 79955-837
FAX: +86+25-83317685
MAIL: wangyong2009@cn.fujitsu.com



------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
