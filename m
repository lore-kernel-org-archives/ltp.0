From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Nov 2017 14:57:40 +0300
Subject: [LTP] [PATCH 3/3] netstress: randomize payload length
In-Reply-To: <20171031122741.spiobpt5ttmtmsii@dell5510>
References: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
 <1507813427-3737-3-git-send-email-alexey.kodanev@oracle.com>
 <20171031122741.spiobpt5ttmtmsii@dell5510>
Message-ID: <031ecc9a-63a7-f322-bee4-0edd1c0fcc3b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 10/31/2017 03:27 PM, Petr Vorel wrote:
> Hi,
>
>> Not default, needs '-A x' option, where x is the upper limit
>> of the random payload.
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> <snip>
>
>> +	if (tst_parse_int(Aarg, &max_rand_msg_len, 10, max_msg_len))
>> +		tst_brk(TBROK, "Invalid max randome payload size '%s'", Aarg);
>                                           ^ typo?
>
> Otherwise looks good to me.


Fixed and applied.

Thanks,
Alexey

