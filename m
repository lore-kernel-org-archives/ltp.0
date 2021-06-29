From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jun 2021 09:02:13 +0200
Subject: [LTP] [PATCH 1/1] delete_module0{1,
 3}: Skip when kernel is locked down
In-Reply-To: <20210629065836.20932-1-pvorel@suse.cz>
References: <20210629065836.20932-1-pvorel@suse.cz>
Message-ID: <YNrFdXeCRXUko2Ua@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Lockdown requires signed modules, otherwise tests fails with EPERM.
> TCONF until we solve signing modules in LTP build.
BTW up now only 4 tests are using tst_lockdown_enabled() check, but maybe it's a
time to add flag .skip_on_lockdown, as docparse would benefit from it.

Kind regards,
Petr
