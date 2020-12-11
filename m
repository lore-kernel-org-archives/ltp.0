From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Dec 2020 13:45:03 +0100
Subject: [LTP] [PATCH v2 00/10] Introduce TST_EXP_MACROS
In-Reply-To: <20201210141548.10982-1-chrubis@suse.cz>
References: <20201210141548.10982-1-chrubis@suse.cz>
Message-ID: <X9Npz/HslBQWdGFb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Very nice helpers!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Another tip for future: many tests would benefit for handling some errno as
TCONF (e.g. TST_EXP_{FAIL,PASS}_TCONF(), but it's be nice if more than one could
be passed).

Kind regards,
Petr
