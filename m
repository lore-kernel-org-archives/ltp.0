From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 May 2020 19:19:21 +0200
Subject: [LTP] [PATCH] pty04: Correct struct member sizes and add to CVE
 runtest file
In-Reply-To: <20200506170407.5562-1-rpalethorpe@suse.com>
References: <20200506170407.5562-1-rpalethorpe@suse.com>
Message-ID: <20200506171921.GA1214@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Also remove min_kver because it is arbitrary. We know this test works on much
> older kernels, but it will probably hit bugs that have been fixed for a long
> time.

Thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Waiting for reactions to .min_kver removal.
nit: I might separate runtest change into it's own commit.

Kind regards,
Petr
