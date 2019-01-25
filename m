From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Jan 2019 15:46:24 +0100
Subject: [LTP] [PATCH 1/1] commands/ld01: Fix shared library detection
 on file >= 5.33
In-Reply-To: <20190123091118.28303-1-pvorel@suse.cz>
References: <20190123091118.28303-1-pvorel@suse.cz>
Message-ID: <20190125144624.GA12068@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Since commit 6876ebad ("add a conditional in description") in file util
> shared library is described as "LSB pie executable", thus check for it
> as well.

> + do more precise check for old versions ('shared object').

FYI merged.

Kind regards,
Petr
