From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Mar 2021 08:16:14 +0100
Subject: [LTP] [PATCH v4] IMA: Allow only ima-buf template for key
 measurement
In-Reply-To: <20210322173709.22150-1-nramas@linux.microsoft.com>
References: <20210322173709.22150-1-nramas@linux.microsoft.com>
Message-ID: <YFmVvvqhLpTGAvVU@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lakshmi, Mimi,

merged this one with slightly updated text of docs and commit message.

...
> +check_policy_template()
> +{
> +	while read line; do
> +	if ( echo $line | grep -q 'template=') && ( ! echo $line | grep -q 'template=ima-buf' ); then
FYI: parentheses are not necessary, thus I removed them.
> +		tst_res TCONF "only template=ima-buf can be specified for KEY_CHECK"
> +		return 1
> +	fi

Kind regards,
Petr
