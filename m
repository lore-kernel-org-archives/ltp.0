From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 13:42:45 +0100
Subject: [LTP] [PATCH 0/3] Add proper filesystem skiplist
In-Reply-To: <20210310122625.25425-1-chrubis@suse.cz>
References: <20210310122625.25425-1-chrubis@suse.cz>
Message-ID: <YEi+xbtuFC6/uiwf@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> This adds a proper .skip_filesystems array to the tst_test structure and
> implements support for both test with .all_filesystems enabled and
> disabled.

> As a bonus point we get the list of filesystems that the test does not
> support exported to the metadata as well.

Whole patchset looks very nice, thanks for implementing it.
I post minor formatting nit on first patch.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
