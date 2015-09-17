From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 17 Sep 2015 11:45:52 +0300
Subject: [LTP] [PATCH] lib/test_net.sh: add waiting loop to netload()
In-Reply-To: <675138819.13128994.1442475711763.JavaMail.zimbra@redhat.com>
References: <1442396622-29765-1-git-send-email-alexey.kodanev@oracle.com>
 <675138819.13128994.1442475711763.JavaMail.zimbra@redhat.com>
Message-ID: <55FA7DC0.7000206@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 09/17/2015 10:41 AM, Jan Stancek wrote:
>> @@ -282,6 +282,17 @@ tst_netload()
>>   		tst_resm TINFO "run tcp_fastopen with '$ip_addr', port '$port'"
>>   		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests -g $port"
>>   
>> +		# check that tcp_fastopen on rhost in 'Listening' state
>> +		local sec_waited=
>> +		for sec_waited in $(seq 1 60); do
>> +			tst_rhost_run -c "ss -ln | grep -q $port" && break
> Isn't this too generic match? Can we add "-t" to ss parameters?
> "ss -ln" gives me also unix sockets along with their inode numbers on output,
> which seems they could easily match any port number.

Right, we can use -t option to match only TCP sockets... I'll add it.

Thanks,
Alexey

