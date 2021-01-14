From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 14 Jan 2021 14:46:29 +0100
Subject: [LTP] [PATCH v6 2/3] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <YABJTK2hRHBjJ6lc@yuki.lan>
References: <20210112095759.11910-1-mdoucha@suse.cz>
 <20210112095759.11910-2-mdoucha@suse.cz> <YABJTK2hRHBjJ6lc@yuki.lan>
Message-ID: <ef29118b-436a-5d2f-1bde-2a5b3ac78290@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14. 01. 21 14:38, Cyril Hrubis wrote:
> Hi!
>> +int tst_secureboot_enabled(void)
>> +{
>> +	int fd;
>> +	char data[5];
>> +
>> +	if (access(EFIVAR_SECUREBOOT, F_OK)) {
>> +		tst_res(TINFO, "Efivar FS not available");
>> +		return -1;
>> +	}
>> +
>> +	fd = open(EFIVAR_SECUREBOOT, O_RDONLY);
>> +
>> +	if (fd == -1) {
>> +		tst_res(TINFO | TERRNO,
>> +			"Cannot open SecureBoot Efivar sysfile");
>> +		return -1;
>> +	} else if (fd < 0) {
>> +		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
>> +		return -1;
>> +	}
> 
> If we change the access() above to R_OK we can just do SAFE_OPEN() here, right?
> 
> Other than this the code looks good.

We could change it, but I'd prefer to know that the Efivar FS exists but
cannnot be open()ed due to missing permissions than to mix these two
states into the same vague info message.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
