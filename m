From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Wed, 19 May 2021 10:32:10 +0300
Subject: [LTP] [PATCH] network/lib6/getaddrinfo01: rewrite with the new
 API + use static hostnames
In-Reply-To: <YKQSTR1wkB/U81Em@pevik>
References: <20210518091422.41857-1-aleksei.kodanev@bell-sw.com>
 <YKQSTR1wkB/U81Em@pevik>
Message-ID: <b7744613-ee02-c4a5-e5ed-da3da60a6e7b@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18.05.2021 22:15, Petr Vorel wrote:
> Hi Alexey,
> 
> ...
>> +static void setup(void)
>> +{
>> +	unsigned int i;
>> +	int fd;
> ...
>> +	SAFE_CP(host_file, "hosts");
> One more thing, could we check for /etc/hosts before?

Hi Petr,

Yes, why not. I assume it can be read-only, but I hope we won't hide a
configuration bug with this...

> Because we want to TCONF on systems without it not TBROK.
> And I guess there are embedded systems without it out there.
> 
> Kind regards,
> Petr
> 

