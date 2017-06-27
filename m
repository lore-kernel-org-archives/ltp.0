From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Jun 2017 14:24:03 +0200
Subject: [LTP] [RFC PATCH 1/1] lib/test.sh: Fix 'unbound variable' error
In-Reply-To: <20170523081154.19326-1-pvorel@suse.cz>
References: <20170523081154.19326-1-pvorel@suse.cz>
Message-ID: <20170627122403.GB12689@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Some distros have set nounset as default, which requires to fix testing
> optional variables.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I don't want to disable check with 'set +o nounset' in each script, I think
> it's actually quite good to have it. It just requires taking care when using
> optional variables. But it might be better to set it at the top:
> TST_NO_CLEANUP="${TST_NO_CLEANUP:-}"
> LTP_IPC_PATH="${LTP_IPC_PATH:-}"

That sounds better to me, maybe with a short comment that we are trying
to avoid problems on nounset.

-- 
Cyril Hrubis
chrubis@suse.cz
