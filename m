From: Enji Cooper (yaneurabeya) <yaneurabeya@gmail.com>
Date: Sun, 3 Nov 2019 22:54:30 -0800
Subject: [LTP] [RFC PATCH] build: Remove {config.h, config.mk,
 features.mk, }.default
In-Reply-To: <20191104064119.11510-1-pvorel@suse.cz>
References: <20191104064119.11510-1-pvorel@suse.cz>
Message-ID: <BDDF3071-8590-4869-BCAD-458E58DA1CDD@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Nov 3, 2019, at 22:41, Petr Vorel <pvorel@suse.cz> wrote:
> 
> Nowadays most distributions have autoconf, we can require it.
> 
> include/config.h.default was outdated anyway.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> BTW INSTALL needs update. doc/mini-howto-building-ltp-from-git.txt is in
> much better shape, but contains just compilation from git.
> 
> I'd either create single markdown page doc/installation.txt, which would
> contain both installation from tarball and git (preferred) or had 2 separate pages.
> 
> And INSTALL only contain see doc/*.

LGTM.

Reviewed by: Enji Cooper <yaneurabeya@gmail.com>
