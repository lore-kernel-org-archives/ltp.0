From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Sep 2021 14:41:38 +0200
Subject: [LTP] [PATCH v2] kernel/irq: Add irqbalance01
In-Reply-To: <20210831114406.8527-1-rpalethorpe@suse.com>
References: <878s0ikl6d.fsf@suse.de>
 <20210831114406.8527-1-rpalethorpe@suse.com>
Message-ID: <YToBAshr0Y94qcVU@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/* Read the CPU affinity masks for each IRQ. See bitmap_string() in the kernel (%*pb) */
> +	for (row = 0; row < nr_irqs; row++) {
> +		sprintf(path, "/proc/irq/%u/smp_affinity", irq_ids[row]);
> +		ret = SAFE_FILE_READAT(0, path, buf, size);
> +		if (ret < 1)
> +			tst_brk(TBROK, "Empty /proc/irq/%u/smp_affinity?", irq_ids[row]);
> +		c = buf;
> +		col = 0;
> +
> +		while (*c != '\0') {
> +			switch (*c) {
> +			case '\n':
> +			case ' ':
> +			case ',':
> +				c++;
> +				continue;
> +			case '0' ... '9':
> +				acc = *c - '0';
> +				break;
> +			case 'a' ... 'f':
> +				acc = 10 + *c - 'a';
> +				break;
> +			default:
> +				tst_res(TINFO, "%u/smp_affnity: %s", irq_ids[row], buf);
> +				tst_brk(TBROK, "Wasn't expecting 0x%02x", *c);
> +			}
> +
> +			for (mask_pos = 0; mask_pos < 4; mask_pos++) {
> +				if (mask_pos + col >= nr_cpus)
> +					break;
> +
> +				irq_affinity[row * nr_cpus + (nr_cpus - 1 - col - mask_pos)] =
> +					(acc & (8 >> mask_pos)) ? ALLOW : DENY;
> +			}

The mask here is actually wrong, since we go backward in the
irq_affinity array the bitmask has to grow not shrink so this should be
(acc & (1<<mask_pos))

> +			col += mask_pos;
> +			c++;
> +		}
> +	}
> +
> +	free(buf);
> +}
> +
> +static void print_irq_info(void)
> +{
> +	size_t row, col;
> +	unsigned int count;
> +	enum affinity aff;

It would be nice if we printed the CPUX header here as well so that it's
clear which column describes which CPU.

> +	for (row = 0; row < nr_irqs; row++) {
> +		tst_printf("%5u:", irq_ids[row]);
> +
> +		for (col = 0; col < nr_cpus; col++) {
> +			count = irq_stats[row * nr_cpus + col];
> +			aff = irq_affinity[row * nr_cpus + col] == ALLOW ? '+' : '-';
> +
> +			tst_printf("%10u%c", count, aff);
> +		}
> +
> +		tst_printf("\n");
> +	}
> +
> +	tst_printf("Total:");
> +
> +	for (col = 0; col < nr_cpus; col++)
> +		tst_printf("%11u", irq_stats[row * nr_cpus + col]);
                               ^
			       And I would change this to "%10u " so
			       that the value aligns with the rest of
			       the numbers in the columns.
> +	tst_printf("\n");
> +}

Otherwise the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
