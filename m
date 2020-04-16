From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 16 Apr 2020 15:40:20 +0200
Subject: [LTP] [PATCH v2] Add test for CVE 2018-9568
In-Reply-To: <20200416133020.GA15339@yuki.lan>
References: <20200416122023.20952-1-mdoucha@suse.cz>
 <20200416133020.GA15339@yuki.lan>
Message-ID: <1ed0003e-126f-5c3d-0fdf-9e41ea9ff1eb@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16. 04. 20 15:30, Cyril Hrubis wrote:
> Hi!
>> +++ b/testcases/kernel/syscalls/connect/connect02.c
>> @@ -0,0 +1,105 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Unless the original reproducer is under GPL-2.0 the default should be
> GPL-2.0-or-later. I can change it before applying if it's OK to do so.

Sorry, I copy-pasted the header from the ptrace08 test. This one should
be GPL-2.0-or-later so please change it.

> Also looking at spdx.org GPL-2.0 is not valid and it should be
> GPL-2.0-only.

I guess we should also ask Andrew Lutomirsky which licence to use in
ptrace08 then.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
