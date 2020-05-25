From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 May 2020 16:15:10 +0200
Subject: [LTP] [PATCH v2 3/3] Add test for CVE 2017-1000111
In-Reply-To: <20200505152315.29216-3-mdoucha@suse.cz>
References: <20200505152315.29216-1-mdoucha@suse.cz>
 <20200505152315.29216-3-mdoucha@suse.cz>
Message-ID: <20200525141510.GC26837@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> +static void setup(void)
> +{
> +	int real_uid = getuid();
> +	int real_gid = getgid();

Don't we want to add here taint check (you had it in v1)?
tst_taint_init(TST_TAINT_W | TST_TAINT_D);

Otherwise whole patchset LGTM.

Kind regards,
Petr
