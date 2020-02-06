From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 6 Feb 2020 14:08:20 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <87h803hoz9.fsf@our.domain.is.not.set>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz> <20200205143107.GC30186@rei>
 <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz> <20200205155012.GA4920@rei>
 <2c7e9545-93e3-3460-6006-5e57b982ecc7@suse.cz> <20200205191006.GA18877@rei>
 <87lfpgges0.fsf@our.domain.is.not.set>
 <f50e75f0-5575-0753-5b3e-dc1e6d66e2b7@suse.cz>
 <87imkjhq6m.fsf@our.domain.is.not.set> <87h803hoz9.fsf@our.domain.is.not.set>
Message-ID: <d16cb4d1-08cd-86ba-956d-1f838c143b44@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/6/20 1:36 PM, Richard Palethorpe wrote:
> OTOH, At least with compilers which don't have link time optimisation
> (everything except Clang?), there is an advantage to including stuff
> inline. Hence why fzsync is entirely in the header, although I don't
> think it matters much either way for LTP.

GCC does have link-time optimisation.
CFLAGS += -flto
CXXFLAGS += -flto
LDFLAGS += -flto

The only drawback is that object files will get bigger and linking the
test programs will take significantly longer. But since the performance
overhead of actual LTP code is mostly trivial compared to time spent in
system calls and waiting for I/O operations, I don't think we'll gain
anything by turning these optimizations on.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
