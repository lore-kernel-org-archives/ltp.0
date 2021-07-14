From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 12:46:41 +0200
Subject: [LTP] [PATCH v2 2/8] Add 'make check' to the build system
In-Reply-To: <20210714071158.15868-3-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-3-rpalethorpe@suse.com>
Message-ID: <YO7AkRYcyg8h/ped@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Allows one to run 'make check' or 'make check-$TARGET'. Which will
> execute the CHECK tool with that target's CC arguments and
> CHECK_FLAGS. By default the check tool is tools/sparse/main.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Only build sparse if "make check" is run. It is filtered from "make all".
+1

Kind regards,
Petr
