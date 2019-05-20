From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 16:50:02 +0200
Subject: [LTP] [PATCH] lib: Migrate tst_get_unused_port to new API
In-Reply-To: <20190520141940.GB28976@rei.lan>
References: <20190520135450.22014-1-pvorel@suse.cz>
 <20190520141940.GB28976@rei.lan>
Message-ID: <20190520145002.GA28760@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> Acked.
Thanks.

I'm sorry, current implementation is wrong as it does not print port :).
I'll push it with this diff (I guess we don't need new line for port,
although that's not problematic for shell usage like this:

port=$(tst_get_unused_port ipv${TST_IPVER} stream)

Kind regards,
Petr

--- a/testcases/lib/tst_get_unused_port.c
+++ b/testcases/lib/tst_get_unused_port.c
@@ -54,5 +54,6 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	return TST_GET_UNUSED_PORT(family, type);
+	printf("%d", TST_GET_UNUSED_PORT(family, type));
+	return 0;
 }
