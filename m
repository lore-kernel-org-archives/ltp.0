From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Feb 2021 10:43:35 +0100
Subject: [LTP] [PATCH v2 2/2] close_range02: Add simpler test and Check
 invalid params
In-Reply-To: <20210216074748.6873-2-rpalethorpe@suse.com>
References: <20210216074748.6873-1-rpalethorpe@suse.com>
 <20210216074748.6873-2-rpalethorpe@suse.com>
Message-ID: <YCuTx8angdureqe4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> +	if (fd > -1) {
> +		TST_EXP_PASS_SILENT(close_range(fd, fd, 0),
> +				    "close_range(%d, %d, 0)", fd, fd);

> +		fd = -1;
Removed this line and patchset merged.

Thanks!

Kind regards,
Petr
