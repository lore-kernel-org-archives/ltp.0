From: Erico Nunes <ernunes@redhat.com>
Date: Wed, 22 Jul 2020 17:52:16 +0200
Subject: [LTP] [PATCH 1/3] lib: add function to check for kernel lockdown
In-Reply-To: <20200721152606.GA13733@yuki.lan>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <20200721152606.GA13733@yuki.lan>
Message-ID: <9eba9629-72a3-81e0-03dc-6bb78f19538d@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/21/20 5:26 PM, Cyril Hrubis wrote:
>> +void tst_lockdown_skip(void)
>> +{
>> +	char line[BUFSIZ];
>> +	FILE *file;
>> +
>> +	if (access("/sys/kernel/security/lockdown", F_OK) != 0)
>> +		return;
>> +
>> +	file = SAFE_FOPEN("/sys/kernel/security/lockdown", "r");
>> +	fgets(line, sizeof(line), file);
> 
> The compiler complains that we haven't checked the return value here I
> guess that we can silence it with:
> 
> 	if (!fgets(line, sizeof(line), file)
> 		return;
> 

Thanks, will fix in v2.

