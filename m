From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 12 Mar 2021 18:15:23 +0100
Subject: [LTP] [PATCH 1/2] Add FS quota availability check functions
In-Reply-To: <YEtCWbqdGq5Yc99s@pevik>
References: <20210309171104.30821-1-mdoucha@suse.cz> <YEtCWbqdGq5Yc99s@pevik>
Message-ID: <f775b926-6bd1-2f93-707a-fbbc7ebe6dc4@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12. 03. 21 11:28, Petr Vorel wrote:
> Hi Martin,
> 
>> +int tst_check_quota_support(const char *device, int format,
>> +	const char *quotafile)
>> +{
>> +	TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), device, format, quotafile));
> Actually, there is a warning:
> tst_supported_fs_types.c: In function ?tst_check_quota_support?:
> tst_supported_fs_types.c:117:59: warning: passing argument 4 of ?quotactl? discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
>   117 |  TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), device, format, quotafile));
> 
> Would you prefer to cast to char *, or just change function parameter to char *?

Thanks for catching this. Passing string literals to the function
directly is technically wrong so I'll drop the const and fix the tests
to allocate a buffer for quotafile paths. I'll resubmit on Monday.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
