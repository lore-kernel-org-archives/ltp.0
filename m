Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SDQQ6-0005S6-Ar
	for ltp-list@lists.sourceforge.net; Fri, 30 Mar 2012 01:14:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SDQQ4-0003W1-Bp
	for ltp-list@lists.sourceforge.net; Fri, 30 Mar 2012 01:14:26 +0000
Message-ID: <4F7508AF.6070408@cn.fujitsu.com>
Date: Fri, 30 Mar 2012 09:13:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAGH67wR9ZGjypQbE_oWb1pM=U4=oetNFrberWD66sZj4o9Lm3g@mail.gmail.com>
	<1333069515-4899-1-git-send-email-penght@cn.fujitsu.com>
	<CAGH67wQ9xgA2f_t=524My2uzyeRnuMWTyZfDQQU_zkMhuca8Vg@mail.gmail.com>
In-Reply-To: <CAGH67wQ9xgA2f_t=524My2uzyeRnuMWTyZfDQQU_zkMhuca8Vg@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] cron02: fix a bug of /etc/init.d/crond is
	nonexistent
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 03/30/2012 09:07 AM, Garrett Cooper wrote:

> On Thu, Mar 29, 2012 at 6:05 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
>> /etc/init.d/crond is nonexistent in fedora16, so should use systemctl.
>>
>> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
>> ---
>>  testcases/commands/cron/cron02 |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
>> index 0c05c95..d348936 100755
>> --- a/testcases/commands/cron/cron02
>> +++ b/testcases/commands/cron/cron02
>> @@ -52,12 +52,26 @@ do_setup(){
>>         }
>>         fi
>>
>> +       # running under systemd?
>> +       if command -v systemctl >/dev/null 2>&1; then
>> +               HAVE_SYSTEMCTL=true
>> +       else
>> +               HAVE_SYSTEMCTL=false
>> +       fi
>> +
>>        # restart cron daemon
>>        # Red Hat uses crond, SuSE/Other uses cron.
>>        if [ -x /etc/init.d/crond ]; then
>>                /etc/init.d/crond restart
>>        elif [ -x /etc/init.d/cron ]; then
>>                /etc/init.d/cron restart
>> +       elif $HAVE_SYSTEMCTL; then
>> +               for crond in "crond" "cron"; do
>> +                       if systemctl is-enabled $crond.service >/dev/null 2>&1; then
>> +                               systemctl restart $crond.service
>> +                               break
>> +                       fi
>> +               done
>>        else
>>                echo "Could not determine cron init.d script."
>>                exit 1
> 
> Reviewed-by: Garrett Cooper <yanegomi@gmail.com>


pushed, thanks Peng, Garrett,

Wanlong Gao

> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
