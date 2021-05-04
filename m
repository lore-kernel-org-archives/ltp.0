From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 May 2021 15:10:58 +0200
Subject: [LTP] [PATCH v3 1/1] docparse: Escape backslash,
 tab and double quote in JSON
In-Reply-To: <20210504125729.18781-1-pvorel@suse.cz>
References: <20210504125729.18781-1-pvorel@suse.cz>
Message-ID: <YJFH4vLeaXnc8mzN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static inline void data_fprintf_esc(FILE *f, unsigned int padd, const char *str)
> +{
> +	while (padd-- > 0)
> +		fputc(' ', f);
> +
> +	fputc('"', f);
> +
> +	while (*str) {
> +		switch (*str) {
> +		case '\\':
> +			fputs("\\\\", f);
> +			break;
> +		case '"':
> +			fputs("\\\"", f);
> +			break;
> +		case '\t':
> +			fputs("\\t", f);
> +			break;
> +		default:
> +			putc(*str, f);
> +			break;
> +		}
> +		str++;
> +	}
> +
> +	fputc('"', f);
> +}

Also does this even escape newlines? If you write "\n" in C it's stored
in memory as [0x0a, 0x00], no actual \ are stored in the string. What
the '\\' case does it to escape literal backslash i.e. "\\" which is
stored as [0x5c, 0x00]. Looking at JSON specification anything that is
in ascii before 0x20 (space) is invalid character in a JSON string. I
guess that the safest to write strings would be:

	...
	default:
		if (*str >= 20)
			putc(*str, f);
	}

And we would have to add escape at least for '\n' the same way we have
for '\t' in the switch.

-- 
Cyril Hrubis
chrubis@suse.cz
