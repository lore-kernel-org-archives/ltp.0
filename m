From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 7 Mar 2017 16:09:39 +0100
Subject: [LTP] Android build and pthread
Message-ID: <20170307150938.eeddwzgjxlle4yus@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steven,

just out of curiosity, your commit log 34a7c82a7abd0a72746c2369ebdbc34e267b2c44
mentions stub library:

    It implements s subset of libpthread and librt, but they'res contained
    in libc. Rather than forcing existing and future tests to use a
    conditional or variable to add -lpthread I've just created a stub
    library.

Also the code contains:
+ifneq ($(ANDROID),1)
+FILTER_OUT_DIRS		+= android_libpthread android_librt

Where is that "stub library"? Is it meant to be android_libpthread and android_librt? BTW
I haven't found android_libpthread neither android_librt in code. Am I missing something?


Kind regards,
Petr
