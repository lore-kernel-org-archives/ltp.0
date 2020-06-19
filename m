From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jun 2020 11:17:47 +0200
Subject: [LTP] [PATCH v2 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <20200612143842.3993-3-t-josne@linux.microsoft.com>
References: <20200612143842.3993-1-t-josne@linux.microsoft.com>
 <20200612143842.3993-3-t-josne@linux.microsoft.com>
Message-ID: <20200619091747.GB9372@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

Just a 2 nit changes for second test:

> +test2() {
> +	local keyring_id key_id test_file="$PWD/test.txt"
	local keyring_id key_id
	local test_file="test.txt"

> +	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
	[ -f $CERT_FILE ] || tst_brk TCONF "missing x509 certificate ($CERT_FILE)"

...
plus removing
rm $test_file

It's in my branch
https://github.com/pevik/ltp/tree/Lachlan_Sneff/ima_keys.sh.v3.fixes/

Can you please have a look, so I can push it?

BTW could you please send me your IMA files (ascii_runtime_measurements should
be enough)?

Kind regards,
Petr
