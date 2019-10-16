From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Oct 2019 15:30:39 +0200
Subject: [LTP] [PATCH 1/2] lib: Add support for test tags
In-Reply-To: <20191014112522.24548-2-chrubis@suse.cz>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-2-chrubis@suse.cz>
Message-ID: <20191016133039.GA6842@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +	if (tags) {
> +		for (i = 0; tags[i].name; i++) {
> +			if (!strcmp(tags[i].name, "CVE"))
> +				printf(CVE_DB_URL "%s\n", tags[i].value);
> +			else if (!strcmp(tags[i].name, "linux-git"))
Not sure if it's worth of defining some enums instead of "CVE", "linux-git"
(would catch typos).

> +				printf(LINUX_GIT_URL "%s\n", tags[i].value);

> +			else
> +				printf("%s: %s\n", tags[i].name, tags[i].value);
> +			printf("\n");

Kind regards,
Petr
