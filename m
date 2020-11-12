From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2020 15:21:46 +0100
Subject: [LTP] [PATCH v3 1/2] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <20201109164605.25965-1-mdoucha@suse.cz>
References: <20201109164605.25965-1-mdoucha@suse.cz>
Message-ID: <20201112142146.GA19824@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've looked into the library and what it actually does in this case is
that it opens a sysfs file and reads a few bytes from there. I guess
that we can even avoid linking the library in this case, since we just
want to know a value of the single bit in the SecureBoot file.

The full path is:

/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c

The SecureBoot is the name of the variable and the hex numbers
represends the global GUID.

Now on my system with secure boot disabled the content of the file looks
like:

cat /sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c  |xxd
00000000: 0600 0000 00                             .....

The first four bytes are attributes, we can ingore them and the last
byte is the data byte, which tells us if secure boot is enabled or not.

So it may be as well easier to:

* Check if that file exists

* Read five bytes and return the last one

-- 
Cyril Hrubis
chrubis@suse.cz
