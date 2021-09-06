From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 6 Sep 2021 14:40:11 +0200
Subject: [LTP] [PATCH 3/7] Add user/group ID lookup helper functions
In-Reply-To: <YTYH4DdeUqsYeglK@yuki>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-4-mdoucha@suse.cz> <YTYH4DdeUqsYeglK@yuki>
Message-ID: <528952e4-bebf-617e-4d3f-0aea39797584@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06. 09. 21 14:21, Cyril Hrubis wrote:
> Hi!
>> +	if (!ret) {
>> +		if (errno) {
>> +			tst_brk_(file, lineno, TBROK | TERRNO,
>> +				"getpwent() failed");
>> +		} else {
>> +			tst_brk_(file, lineno, TBROK,
>> +				"getpwent() failed: end of file");
>> +		}
> 
> I'm not sure if "no more users in the /etc/passwd" should be reported as
> an error.

The alternative would be that pretty much every test that calls
SAFE_GETPWENT() in setup() will need to check for NULL and explicitly
call tst_brk(). I don't see any use for allowing SAFE_GETPWENT() to
return NULL outside cleanup().

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
