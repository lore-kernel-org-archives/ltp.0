From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Aug 2016 12:47:27 +0300
Subject: [LTP] [PATCH 3/8] syscalls/waitpid: implement waitpid_ret_test()
In-Reply-To: <20160818155423.GC31953@rei.lan>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815152739.GG20680@rei.lan> <57B585E7.9020000@oracle.com>
 <20160818104245.GA24254@rei.lan> <57B5D10A.4070406@oracle.com>
 <20160818155423.GC31953@rei.lan>
Message-ID: <57B6D5AF.2040003@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 08/18/2016 06:54 PM, Cyril Hrubis wrote:
> Hi!
>> #define WAITPID_RET_TEST(wp_pid, wp_status, wp_opts, wp_ret, wp_errno)  \
>>         do {                                                            \
>>                 if (waitpid_ret_test(wp_pid, wp_status,                 \
>>                                      wp_opts, wp_ret, wp_errno)) {      \
>>                         tst_res_(__FILE__, __LINE__, TFAIL,             \
>>                                  "waitpid_ret_test() failed");          \
>>                         return;                                         \
>>                 }                                                       \
>>         } while (0)
>>
>> ?
>>
>> This will produce:
>>
>> [stas@kholmanskikh waitpid]$ ./waitpid07
>> tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
>> waitpid_common.h:97: FAIL: waitpid() returned 0, expected 666
>> waitpid07.c:51: FAIL: waitpid_ret_test() failed
> 
> I guess that we can go this way and turn the last TFAIL into the TINFO.
> 
> Well, we may also do something as:
> 
> #define TST_TRACE(expr) \
> 	({int ret = expr; ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret;})

I like this idea with '#expr'.

Do you want me to put this in tst_test.h, or is it acceptable if I keep
this in waitpid_common.h? If it's acceptable, I'd rename it to
WAITPID_TEST and used the 'return' statement"

#define WAITPID_TEST(expr) \
   do { \
      if (expr) { \
          tst_rest(TINFO, #expr " failed"); \
          return; \
      } \
   } while (0);

and call it

WAITPID_TEST(waitpid_ret_test());
WAITPID_TEST(reap_children());

> 
> 
> Then call it as:
> 
> 	if (TST_TRACE(waitpid_ret_test(...)))
> 		return;
> 
