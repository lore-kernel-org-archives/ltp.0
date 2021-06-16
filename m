From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Jun 2021 15:24:23 +0800
Subject: [LTP] [PATCH v4 1/3] Add Coccinelle helper scripts for reference
In-Reply-To: <20210615074045.23974-1-rpalethorpe@suse.com>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2fgVnh4w9Vgezvu7-YmLXLJiKEkLyz5puTjgo=9=neidg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> +for spatch_file in $*; do
> +    case $spatch_file in
> +       libltp-test-macro)
> +           libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro.cocci;;
> +       libltp-test-macro-vars)
> +           libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro-vars.cocci \
> +                         --ignore lib/tst_test.c;;
> +       *)
> +           tests_spatch --sp-file scripts/coccinelle/$spatch_file.cocci;;

Why here use the coccinelle/ path and add suffix with the spatch_file?
Wouldn't this below more simple to us:

   scripts/coccinelle/$spatch_file.cocci  ==> $spatch_file

> +    esac
> +done




--
Regards,
Li Wang

