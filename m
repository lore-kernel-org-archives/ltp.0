From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Oct 2015 18:40:31 +0200
Subject: [LTP] [PATCH v3] mem/hugetlb: shift an empty region to use in
 hugemmap02.c
In-Reply-To: <1444745490-9044-1-git-send-email-liwang@redhat.com>
References: <1444745490-9044-1-git-send-email-liwang@redhat.com>
Message-ID: <20151013164030.GB27888@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  int main(int ac, char **av)
>  {
> @@ -127,15 +130,29 @@ int main(int ac, char **av)
>  			addrlist[i] = addr;
>  		}
>  
> +		while (range_is_mapped(low_addr, low_addr + 0x1000) == 1) {

                                                          ^ + map_sz?

> +			low_addr = low_addr + 0x10000000;
> +
> +			if (low_addr < LOW_ADDR)
> +				tst_brkm(TBROK | TERRNO, cleanup,
> +						"no empty region to use");
> +		}

Well, if we do not call tst_brkm() in the range_is_mapped() function we
should check here that the return value wasn't -1 and exit the test
accordingly...

-- 
Cyril Hrubis
chrubis@suse.cz
