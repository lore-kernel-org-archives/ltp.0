From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Jan 2017 16:36:38 +0300
Subject: [LTP] [PATCH] test_net.sh: add tst_wait_ipv6_dad()
In-Reply-To: <20170124153732.GA31989@rei.lan>
References: <1484139234-14043-1-git-send-email-alexey.kodanev@oracle.com>
 <20170124153732.GA31989@rei.lan>
Message-ID: <4f68abe5-f7b6-d167-ac67-39979e6d077d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/24/2017 06:37 PM, Cyril Hrubis wrote:
> Hi!
>> +tst_wait_ipv6_dad()
>> +{
>> +	local ret=
>> +	local i=
>> +	local iface_loc=${1:-$(tst_iface)}
>> +	local iface_rmt=${2:-$(tst_iface rhost)}
>> +
>> +	for i in $(seq 1 5); do
>> +		ip a sh $iface_loc | grep -q tentative
>> +		ret=$?
>> +
>> +		tst_rhost_run -c "ip a sh $iface_rmt | grep -q tentative"
>> +
>> +		[ $ret -ne 0 -a $? -ne 0 ] && return
>> +
>> +		if [ $i -ne 5 ]; then
>> +			tst_resm TINFO "wait for IPv6 DAD completion $i/5 sec"
>> +			tst_sleep 1s
> My only concern here is that sleeping for 1s is too much and will slow
> down things more than it should. How long this operation usually takes?
> Can we reduce the sleep to 0.1s here and print the TINFO only
> if [ $((i % 10)) -eq 0 ] ?

Changed to 100ms and applied.
