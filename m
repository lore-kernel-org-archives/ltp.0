From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 3 Mar 2021 14:30:37 +0100
Subject: [LTP] [PATCH] Wait for complete input provided by `seq`
In-Reply-To: <20210303132403.6427-1-mloviska@suse.de>
References: <20210303132403.6427-1-mloviska@suse.de>
Message-ID: <YD+PfUQ0ckUtyqse@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'd accept this quick fix although Cyril suggested in original PR [1] that
proper solution would be to generate it's input without relying on shell piping
data into it.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/pull/796#issuecomment-789710935
