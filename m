From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 24 Jun 2021 15:33:10 +0200
Subject: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
In-Reply-To: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
Message-ID: <018a369f-473b-524d-f81b-eb8be4df49bb@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24. 06. 21 15:22, Krzysztof Kozlowski wrote:
> On big memory systems, e.g. 196 GB RAM machine, the ioctl_sg01 test was
> failing because of OoM killer during memory pollution:
> 
> ...
> 
> It seems leaving hard-coded 128 MB free memory works for small or medium
> systems, but for such bigger machine it creates significant memory
> pressure triggering the out of memory reaper.
> 
> The memory pressure usually is defined by ratio between free and total
> memory, so adjust the safety/spare memory similarly to keep always 0.5%
> of memory free.

Hi,
I've sent a similar patch for the same issue a while ago. It covers a
few more edge cases. See [1] for the discussion about it.

[1]
https://patchwork.ozlabs.org/project/ltp/patch/20210127115606.28985-1-mdoucha@suse.cz/

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
