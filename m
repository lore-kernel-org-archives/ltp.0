From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 5 Feb 2020 17:17:34 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <20200205155012.GA4920@rei>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz> <20200205143107.GC30186@rei>
 <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz> <20200205155012.GA4920@rei>
Message-ID: <2c7e9545-93e3-3460-6006-5e57b982ecc7@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/5/20 4:50 PM, Cyril Hrubis wrote:
> That's only true if we are building and external interface for a
> library, here we are just avoiding copy&paste by the simpliest means
> available.

I am building external interface for a library. The library is called
bpf_common. But if you still disagree with splitting the executable code
into a separate file to make the header more readable for developers of
future BPF tests, I'll gladly unassign myself from this task and go work
on something else.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
