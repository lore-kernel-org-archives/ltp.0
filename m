From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Mar 2020 06:56:39 +0100
Subject: [LTP] [PATCH] Add test for CVE 2018-1000199
In-Reply-To: <20200319162114.3967-1-mdoucha@suse.cz>
References: <20200319162114.3967-1-mdoucha@suse.cz>
Message-ID: <20200326055639.GA5206@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> +TST_TEST_CONF("This test is only supported on x86 systems")
FYI there is TST_TEST_TCONF().
> +#endif

Kind regards,
Petr
