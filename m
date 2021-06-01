From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 1 Jun 2021 14:19:13 +0300
Subject: [LTP] [PATCH v3] network/lib6/getaddrinfo01: rewrite with the
 new API + use static hostnames
In-Reply-To: <YLYHRQYBwKz+JTlU@pevik>
References: <20210601094807.77790-1-aleksei.kodanev@bell-sw.com>
 <YLYHRQYBwKz+JTlU@pevik>
Message-ID: <3b122ce4-170d-6e7c-7c30-62016b151dea@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01.06.2021 13:09, Petr Vorel wrote:
> Hi Alexey,
> 
>> The test is now independent of various machine settings
>> regarding the test host name as it adds predefined names
>> and aliases to /etc/hosts file and restores it to its
>> original state after completing the test.
> 
>> This should fix the following failures:
>> * when gethostname() returns an alias name that doesn't
>>   match canonical name;
>> * No AAAA record for the returned name from gethostname().
> 
>> Addresses and names added to /etc/hosts are more or less
>> unique, so that there are no conflicts with the existing
>> configuration.
> 
>> Also most of the duplicate code is now gone.
> ...
>> -	tst_resm(TPASS, "getaddrinfo IPv6 SOCK_STREAM/IPPROTO_UDP hints");
>> +	if (access(host_file, W_OK))
> I guess we don't have to bother with R_OK|W_OK (required R_OK for SAFE_CP()),
> as no sane system would have disabled read permission on hosts file.

I think so, and the root will still be able to read it...

> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Merged, thanks for review Petr!

> 
> Thanks!
> 
> Kind regards,
> Petr
> 

