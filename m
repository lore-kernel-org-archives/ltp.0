From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 6 Mar 2020 11:29:50 +0800
Subject: [LTP] [PATCH 1/1] hugeshmctl01: Fix reset stat_time when
 looping with -i n
In-Reply-To: <cd067b8a-224d-993f-8668-e8f7b70f59bc@cn.fujitsu.com>
References: <20200305171844.24020-1-pvorel@suse.cz>
 <cd067b8a-224d-993f-8668-e8f7b70f59bc@cn.fujitsu.com>
Message-ID: <5E61C3AE.402@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/6 9:53, Yang Xu wrote:
>>     static void test_hugeshmctl(unsigned int i)
>>   {
>> +    stat_time = FIRST;
>> +
> My description may confuse you.  stat_time should not be reseted every
> time, it only needs to be reseted when next loop. This value will be +1
>   when call stat_cleanup.
> struct tcase {
>          int cmd;
>          void (*func_test) (void);
>          void (*func_setup) (void);
> } tcases[] = {
>          {IPC_STAT, func_stat, stat_setup},   //stat_time = FIRST
>          {IPC_STAT, func_stat, stat_setup},   //stat_time = SECOND
>
> As you do, the first and second case are same. it should be added into
> the "if == 0".
>
> ps: I personally think old case is more cleaner. Let's hear from others.
>
Hi Petr, Xu

For xu's comment, we can assign 'i' to stat_time and remove 
"stat_time++;" directly:
----------------------------------------
  static void test_hugeshmctl(unsigned int i)
  {
+       stat_time = i;
+
...
-       stat_time++;
----------------------------------------

Thanks,
Xiao Yang



