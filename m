From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Jul 2021 08:49:08 +0200
Subject: [LTP] [PATCH v3,
 1/2] lib/tst_test.sh: Make tst_umount work with argument that has
 trailing slash
In-Reply-To: <20210716140142.GA7113@andestech.com>
References: <20210716140142.GA7113@andestech.com>
Message-ID: <YPUgZGgztmG04Mfa@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
>  	while [ "$i" -lt 50 ]; do
> -		if umount "$device" > /dev/null; then
> +		if umount "$device"/ > /dev/null; then
nit: although previous is working, I'd prefer "$device/"

Kind regards,
Petr
