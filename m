From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 31 Jan 2017 14:27:24 +0300
Subject: [LTP] [PATCH 1/2] test_net.sh: add tst_set_sysctl()
In-Reply-To: <20170131100744.GD29227@rei.lan>
References: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
 <20170131100744.GD29227@rei.lan>
Message-ID: <4017cf9c-3957-0a91-4fa3-8bafdad2f4c4@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 01/31/2017 01:07 PM, Cyril Hrubis wrote:

> Hi!
>> +# tst_set_sysctl NAME VALUE [safe]
>> +# It can handle netns case when sysctl not namespaceified.
>> +tst_set_sysctl()
>> +{
>> +	local name="$1"
>> +	local value="$2"
>> +	local safe=
>> +	[ "$3" = "safe" ] && safe="-s" || safe=""
> Uh, this syntax is confusing, besides isn't safe set to empty string
> anyway?

What if we set TST_NO_CLEANUP just before calling cleanup()
or unset TST_CLEANUP... then we can use ROD, etc. in cleanup?


diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6a85f3..c1e75ec 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -35,6 +35,7 @@ tst_do_exit()

         if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
              -z "$TST_NO_CLEANUP" ]; then
+               export TST_NO_CLEANUP="yes"
                 $TST_CLEANUP
         fi


>
>> +	local add_opt=
>> +	[ "$TST_USE_NETNS" = "yes" ] && add_opt="-e"
>> +
>> +	if [ "$safe" ]; then
>> +		ROD sysctl -qw $name=$value
>> +	else
>> +		sysctl -qw $name=$value
>> +	fi
>> +
>> +	tst_rhost_run $safe -c "sysctl -qw $add_opt $name=$value"
>> +}
> And maybe the function name should say that we are changing the
> parameter both on local and remote machine. Maybe just rename the
> function to tst_set_sysctls().

OK

Thanks,
Alexey

