From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Mar 2017 17:46:09 +0200
Subject: [LTP] [PATCH 3/4] Test for uname26 exploit CVE-2012-0957
In-Reply-To: <20170323162638.6fea756b@linux-v3j5>
References: <20170323162638.6fea756b@linux-v3j5>
Message-ID: <20170327154609.GE21272@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static int check_field(char *bytes, size_t length, char *field)
> +{
> +	size_t i = strlen(bytes) + 1;
> +
> +	for (; i < length; i++) {
> +		if (bytes[i]) {
> +			tst_res(TFAIL, "Bytes leaked in %s!", field);
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}

I guess that this could be void, since we don't use the return value,
but that is very minor...

-- 
Cyril Hrubis
chrubis@suse.cz
