From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Dec 2019 17:48:47 +0100
Subject: [LTP] [PATCH] Make crash02 verbose in standard runfile
In-Reply-To: <20191213133709.11845-1-mdoucha@suse.cz>
References: <20191213133709.11845-1-mdoucha@suse.cz>
Message-ID: <20191213164847.GA18822@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Verbose output from crash02 will be useful for actually reporting bugs
> triggered by the test. With default verbosity level, it's difficult to figure
> out which syscall arguments crashed the system even if you know the random seed
> and can easily re-run `crash02 -xv 2` on a system that uses the same rand()
> implementation.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW help for -x is (and was before this patch) misleading because "hexdump
random code instead" is now for -v2 even without -x (and before it required
-v2). But that's a detail, so I'd be for merging it.

Kind regards,
Petr
