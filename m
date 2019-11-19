From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Nov 2019 06:07:27 -0500 (EST)
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <20191119094156.20348-1-liwang@redhat.com>
References: <20191119094156.20348-1-liwang@redhat.com>
Message-ID: <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> -		while (len) {
> +		while (len >= fi.f_bsize) {

Let's say f_bsize is 512, and len is 1023. We hit ENOSPC for 1023,
len for next round is 511. Loop ends, but we never tried write with
f_bsize or smaller value.

I think we should try len < fi.f_bsize@least once.

>  			ret = write(fd, buf, MIN(len, sizeof(buf)));
>  
>  			if (ret < 0) {
> +				if (errno == ENOSPC) {
> +					len /= 2;
> +					continue;
> +				}

The return below (in original code) doesn't appear to be reachable now.

