From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Feb 2019 22:34:29 +0100
Subject: [LTP] [PATCH] setregid01: Fix security warning for string
 formatting
In-Reply-To: <20190225171220.5827-1-daniel.diaz@linaro.org>
References: <20190225171220.5827-1-daniel.diaz@linaro.org>
Message-ID: <20190225213429.GA5339@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Daniel,

thanks for your patch, merged.

Maybe we should have -Wformat -Wformat-security -Werror=format-security as the
default.

Kind regards,
Petr
