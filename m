From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 16 Aug 2021 15:35:22 +0200
Subject: [LTP] [PATCH v4 2/2] setsockopt08: Avoid confusion by removing
 TCONF
In-Reply-To: <20210816111651.29860-2-rpalethorpe@suse.com>
References: <20210812064741.4246-1-rpalethorpe@suse.com>
 <20210816111651.29860-1-rpalethorpe@suse.com>
 <20210816111651.29860-2-rpalethorpe@suse.com>
Message-ID: <fcfbe512-67b3-36ad-1f65-7ba1d599f8c3@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16. 08. 21 13:16, Richard Palethorpe via ltp wrote:
> When not in compat mode this only tests that bad offsets result in
> EINVAL. When in compat mode, we also test for the vulnerability.
> 
> Therefor I view this as two tests. The TCONF was supposed to indicate
> the configuration didn't allow one of these tests. However it just
> caused confusion with multiple people asking me to change it to
> tst_brk.
> 
> So change it to TINFO.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---

Hi,
for both patches:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
