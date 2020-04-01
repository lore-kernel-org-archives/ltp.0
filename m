From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 1 Apr 2020 12:04:27 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200401095822.GB23773@yuki.lan>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <e9ea8c2a-7c00-26a7-fb1a-0db9ae093620@suse.cz>
 <20200401095822.GB23773@yuki.lan>
Message-ID: <aa695e74-2aed-2b9e-c0c0-7626dfc0a7e1@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01. 04. 20 11:58, Cyril Hrubis wrote:
> The problem here is that gcc10 forbids variables in headers, moving it
> anywhere int the header wouldn't help.

I don't think GCC cares about where exactly the variable came from. It's
only refusing to link multiple definitions of the same symbol. So if we
move the TCID definition into the TST_NO_DEFAULT_MAIN guard block, GCC
linker should stop complaining because the symbol name will become unique.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
