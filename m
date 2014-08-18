Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XJHV9-0004Ki-6e
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 07:37:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XJHV7-0007tn-Qd
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 07:37:11 +0000
Message-ID: <53F1ACA9.805@cn.fujitsu.com>
Date: Mon, 18 Aug 2014 15:35:05 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1407405010-23077-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<2144922040.6431142.1407925292759.JavaMail.zimbra@redhat.com>
In-Reply-To: <2144922040.6431142.1407925292759.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] run_memctl_test.sh: replace the former intercept
 method
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>



On 08/13/2014 06:21 PM, Jan Stancek wrote:
>
>
> ----- Original Message -----
>> From: "Xing Gu" <gux.fnst@cn.fujitsu.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Thursday, 7 August, 2014 11:50:10 AM
>> Subject: [LTP] [PATCH] run_memctl_test.sh: replace the former intercept	method
>>
>> In RHEL6.5GA and RHEL7.0GA, running run_memctl_test.sh outputs
>> "/opt/ltp/testcases/bin/run_memctl_test.sh: line 87: [: -lt:
>> unary operator expected" error. This is because $MEM_AVAIL
>> is empty here, which is caused by command "tr -s [:space:]" that
>> loses efficacy. Using "awk" replaces the former intercept method.
>
> Hi,
>
> or you could put quotes around it:
>   tr -s "[:space:]"
>
> so it's not evaluated as wildcard:
>   # cd /opt/ltp/
>   # echo [:space:]
>   [:space:]
>
>   # cd testcases/bin/
>   # echo [:space:]
>   c
>
>   # ls -al c
>   -rwxrwxr-x. 1 root root 11251 Jul 30 02:20 c
>
> If you're wondering where that "c" comes from:
>   ./testcases/kernel/security/filecaps/c.c
>
> I'm OK with using awk, though commit message could be more clear.
>

I see. Thanks for your review.

Regards,
Xing Gu

> Reviewed-by: Jan Stancek <jstancek@redhat.com>
>
> Regards,
> Jan
>
>>
>> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
>> ---
>>   testcases/kernel/controllers/memctl/run_memctl_test.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/controllers/memctl/run_memctl_test.sh
>> b/testcases/kernel/controllers/memctl/run_memctl_test.sh
>> index 66e8f4f..fe171df 100755
>> --- a/testcases/kernel/controllers/memctl/run_memctl_test.sh
>> +++ b/testcases/kernel/controllers/memctl/run_memctl_test.sh
>> @@ -83,7 +83,7 @@ cd $LTPROOT/testcases/bin/
>>   #################################################################################
>>
>>   # First of all check if the system has sufficient memory
>> -MEM_AVAIL=`cat /proc/meminfo | grep MemTotal | tr -s [:space:] | cut -d" "
>> -f2`;
>> +MEM_AVAIL=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`;
>>   if [ $MEM_AVAIL -lt 262144 ]	# 256MB(as test requires some ~200MB)
>>   then
>>   	echo System does not have sufficient free memory.;
>> --
>> 1.9.3
>>
>>
>> ------------------------------------------------------------------------------
>> Infragistics Professional
>> Build stunning WinForms apps today!
>> Reboot your WinForms applications with our WinForms controls.
>> Build a bridge from your legacy apps to the future.
>> http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> .
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
