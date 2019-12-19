From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 19 Dec 2019 08:43:03 -0500 (EST)
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add return value to
 _tst_expect_{fail, pass}
In-Reply-To: <20191219095050.26106-1-pvorel@suse.cz>
References: <20191219095050.26106-1-pvorel@suse.cz>
Message-ID: <391203935.17412269.1576762983583.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +It's possible to detect whether expected value happened:
> +[source,sh]
> +-------------------------------------------------------------------------------
> +if ! EXPECT_PASS command arg1 2\> /dev/null; then
> +	continue
> +fi
> +-------------------------------------------------------------------------------
> +

Looks useful, ack.

