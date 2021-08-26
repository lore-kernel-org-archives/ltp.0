From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Aug 2021 16:07:58 +0200
Subject: [LTP] [PATCH v2 4/4] Add test for CVE 2018-13405
In-Reply-To: <YSeWymK0elcbiqzt@pevik>
References: <20210826112212.26394-1-mdoucha@suse.cz>
 <20210826112212.26394-4-mdoucha@suse.cz> <YSeWymK0elcbiqzt@pevik>
Message-ID: <89e96508-581a-e60c-58cb-37c0c3b3b176@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26. 08. 21 15:27, Petr Vorel wrote:
> Hi Martin,
> 
>> +/*
>> + * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
>> + *
>> + * CVE-2018-13405
>> + *
>> + * Check for possible privilege escalation through creating files with setgid
>> + * bit set inside a setgid directory owned by a group which the user does not
>> + * belong to. Fixed in:
> Maybe this info could be in docparse, but again, that can be fixed during merge.

Yes, please add the docparse tag during merge.

As for if/else braces, I thought the coding style was to add braces
around multi-line statements even if it's a single command.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
