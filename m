From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Dec 2017 10:50:00 +0100
Subject: [LTP] [PATCH v3 04/12] hugeshmctl01: Fix warning about
 signed/unsigned comparison
In-Reply-To: <20171204163655.8838-5-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-5-punit.agrawal@arm.com>
Message-ID: <20171205095000.adgiui7tqi76ktfq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> The macro N_ATTACH is assumed to be a signed integer which results in
> the below warning when compiling -

> warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>   if (buf.shm_nattch != N_ATTACH + stat_time) {
>                      ^~

> Fix this by explicitly marking N_ATTACH to be an unsigned integer and
> fixing the resulting fallout.

> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
Acked-by: Petr Vorel <pvorel@suse.cz>
