From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 12:49:38 +0200
Subject: [LTP] [PATCH v2 3/8] doc: Add rules and recommendations list
In-Reply-To: <20210714071158.15868-4-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-4-rpalethorpe@suse.com>
Message-ID: <YO7BQjUuCP3ah5wu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

obviously correct.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/doc/test-writing-guidelines.txt
> @@ -10,6 +10,11 @@ NOTE: See also
>        https://github.com/linux-test-project/ltp/wiki/Shell-Test-API[Shell Test API],
>        https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP Library API Writing Guidelines].

> +Rules and recommendations which are "machine checkable" should be
> +tagged with an ID like +LTP-XXX+. There will be a corresponding entry
> +in 'doc/rules.tsv'. When you run 'make check' or 'make check-test' it
nit: I'd make 'doc/rules.tsv' as link (for lazy people like me):
https://github.com/linux-test-project/ltp/tree/master/doc/rules.tsv[doc/rules.tsv]

Kind regards,
Petr
