From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Apr 2020 10:26:02 +0200
Subject: [LTP] [PATCH V2] common_timers: staticize all definitions
In-Reply-To: <d39e442b4c0e60880f1da3f69125afa01418f8c1.1588061382.git.viresh.kumar@linaro.org>
References: <d39e442b4c0e60880f1da3f69125afa01418f8c1.1588061382.git.viresh.kumar@linaro.org>
Message-ID: <20200428082602.GA13586@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Staticize all variable and function definitions to avoid build failures
> in the future if this gets included by multiple files.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
