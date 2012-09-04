Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cxie@redhat.com>) id 1T8i9a-0004Km-Pj
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 01:42:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T8i9Z-0005gy-D1
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 01:42:10 +0000
Message-ID: <50455C5D.6020201@redhat.com>
Date: Tue, 04 Sep 2012 09:41:49 +0800
From: cxie <cxie@redhat.com>
MIME-Version: 1.0
References: <CALFGhcTOGwfj=WQJL8FJn8q8LsEPe3fD+KEJBTjidxM47=PL6A@mail.gmail.com>
In-Reply-To: <CALFGhcTOGwfj=WQJL8FJn8q8LsEPe3fD+KEJBTjidxM47=PL6A@mail.gmail.com>
Subject: Re: [LTP] Compling LTP for android Using Ndk revision 8
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7432358128935804650=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: vikas bisla <vikasbisla15@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============7432358128935804650==
Content-Type: multipart/alternative;
	boundary="------------040901050302060201090901"

This is a multi-part message in MIME format.
--------------040901050302060201090901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vikas,
     I looked that code. And think that your arch or system is not 
supported by this file.
     Here is line 61 to 69:
-----------------------
#if CRAY
#define B_MULT    BSIZE        /* block size */
#elif sgi
#define B_MULT    BBSIZE        /* block size */
#elif defined(__linux__) || defined(__sun) || defined(__hpux)
#define B_MULT    DEV_BSIZE    /* block size */
#elif defined(_AIX)
#define B_MULT UBSIZE
#endif
------------------------
     you can check if your compiler contain one of these macro by 
following command:
            gcc -E -dM - < /dev/null           # maybe you need change 
gcc to
                                                            # 
=/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc

     if none of (CRAY  sgi  __linux__    __sun   __hpux  _AIX) is 
defined,  B_MULT won't be defined.
     So, you can find the right Macro and block size for your system and 
add them to this file.

     Also you can add a line  like this to line 70 simplely:
                 #ifndef B_MULT
                 #define B_MULT 1024       /*you should change 1024 to 
the block size of you system.*/
                 #endif                                /*once you add 
this, the code can *only* used in *this* system.*/
--
Yours,
Madper Xie.

On 09/03/2012 08:16 PM, vikas bisla wrote:
> Hi All,
>
> We are trying to compile LTP for android using NDK tool chain.
>
> Flags set while configuration-
>
> ./configure --host=arm-eabi 
> CC=/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc 
> CPPFLAGS="-I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/" 
> CFLAGS="-nostdlib" 
> LDFLAGS="-Wl,-rpath-link=/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/ 
> -L/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/" 
> LIBS="-lc"
>
> After Config we are doing
>
> Make ARCH=arm
>
> it is giving following error.
>
> /Desktop/LTP/ltp-full-20120903$ make ARCH=arm
> make -C "lib" \
> -f "/home/vikas/Desktop/LTP/ltp-full-20120903/lib/Makefile" all
> make[1]: Entering directory 
> `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'
> /home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc -nostdlib -g 
> -O2 -fno-strict-aliasing -pipe -Wall 
> -I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/ 
> -I../include -I../include -I../include -I../include  -c -o 
> bytes_by_prefix.o bytes_by_prefix.c
> bytes_by_prefix.c: In function 'bytes_by_prefix':
> bytes_by_prefix.c:94: error: 'B_MULT' undeclared (first use in this 
> function)
> bytes_by_prefix.c:94: error: (Each undeclared identifier is reported 
> only once
> bytes_by_prefix.c:94: error: for each function it appears in.)
> bytes_by_prefix.c: In function 'lbytes_by_prefix':
> bytes_by_prefix.c:142: error: 'B_MULT' undeclared (first use in this 
> function)
> bytes_by_prefix.c: In function 'llbytes_by_prefix':
> bytes_by_prefix.c:193: error: 'B_MULT' undeclared (first use in this 
> function)
> make[1]: *** [bytes_by_prefix.o] Error 1
> make[1]: Leaving directory `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'
> make: *** [lib-all] Error 2
>
> Can anybody please suggest some pointer so that we can go forward.
>
> Regards
> vikas bisla
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--------------040901050302060201090901
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Vikas,<br>
      &nbsp;&nbsp;&nbsp; I looked that code. And think that your arch or system is not
      supported by this file. <br>
      &nbsp;&nbsp;&nbsp; Here is line 61 to 69:<br>
      -----------------------<br>
      #if CRAY<br>
      #define B_MULT&nbsp;&nbsp;&nbsp; BSIZE&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* block size */<br>
      #elif sgi<br>
      #define B_MULT&nbsp;&nbsp;&nbsp; BBSIZE&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* block size */<br>
      #elif defined(__linux__) || defined(__sun) || defined(__hpux)<br>
      #define B_MULT&nbsp;&nbsp;&nbsp; DEV_BSIZE&nbsp;&nbsp;&nbsp; /* block size */<br>
      #elif defined(_AIX)<br>
      #define B_MULT UBSIZE<br>
      #endif<br>
      ------------------------ <br>
      &nbsp;&nbsp;&nbsp; you can check if your compiler contain one of these macro by
      following command: <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gcc -E -dM - &lt; /dev/null&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # maybe you need
      change gcc to <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # <font
        color="#000099">=/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc</font><br>
      <br>
      &nbsp;&nbsp;&nbsp; if none of (CRAY&nbsp; sgi&nbsp; __linux__&nbsp;&nbsp;&nbsp; __sun&nbsp;&nbsp; __hpux&nbsp; _AIX) is
      defined,&nbsp; B_MULT won't be defined.<br>
      &nbsp;&nbsp;&nbsp; So, you can find the right Macro and block size for your
      system and add them to this file. <br>
      <br>
      &nbsp;&nbsp;&nbsp; Also you can add a line&nbsp; like this to line 70 simplely:<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #ifndef B_MULT <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define B_MULT 1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*you should change 1024
      to the block size of you system.*/<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #endif&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*once you
      add this, the code can *only* used in *this* system.*/<br>
      --<br>
      Yours,<br>
      Madper Xie.<br>
      <br>
      On 09/03/2012 08:16 PM, vikas bisla wrote:<br>
    </div>
    <blockquote
cite="mid:CALFGhcTOGwfj=WQJL8FJn8q8LsEPe3fD+KEJBTjidxM47=PL6A@mail.gmail.com"
      type="cite">Hi <font color="#000099">All,</font>
      <div><font color="#000099"><br>
        </font></div>
      <div><font color="#000099">We are trying to compile LTP for
          android using NDK tool chain.&nbsp;</font></div>
      <div><font color="#000099"><br>
        </font></div>
      <div><font color="#000099">Flags set while configuration-&nbsp;</font></div>
      <div><font color="#000099"><br>
        </font></div>
      <div><font color="#000099">./configure --host=arm-eabi
          CC=/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc
          CPPFLAGS="-I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/"
          CFLAGS="-nostdlib"
          LDFLAGS="-Wl,-rpath-link=/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/
          -L/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/"
          LIBS="-lc"</font></div>
      <div><font color="#000099"><br>
        </font></div>
      <div><font color="#000099">After Config we are doing&nbsp;</font></div>
      <div><font color="#000099"><br>
        </font></div>
      <div><font color="#000099">Make ARCH=arm</font></div>
      <div><font color="#000099"><br>
        </font></div>
      <div><font color="#000099">it is giving following error.</font></div>
      <div><font color="#000099"><br>
        </font></div>
      <div><font color="#000099">
          <div>/Desktop/LTP/ltp-full-20120903$ make ARCH=arm</div>
          <div>make -C "lib" \</div>
          <div><span class="Apple-tab-span" style="white-space:pre"> </span>-f
            "/home/vikas/Desktop/LTP/ltp-full-20120903/lib/Makefile" all</div>
          <div>make[1]: Entering directory
            `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'</div>
          <div>/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc
            -nostdlib -g -O2 -fno-strict-aliasing -pipe -Wall
            -I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/
            -I../include -I../include -I../include -I../include &nbsp;-c -o
            bytes_by_prefix.o bytes_by_prefix.c</div>
          <div>bytes_by_prefix.c: In function 'bytes_by_prefix':</div>
          <div>bytes_by_prefix.c:94: error: 'B_MULT' undeclared (first
            use in this function)</div>
          <div>bytes_by_prefix.c:94: error: (Each undeclared identifier
            is reported only once</div>
          <div>bytes_by_prefix.c:94: error: for each function it appears
            in.)</div>
          <div>bytes_by_prefix.c: In function 'lbytes_by_prefix':</div>
          <div>bytes_by_prefix.c:142: error: 'B_MULT' undeclared (first
            use in this function)</div>
          <div>bytes_by_prefix.c: In function 'llbytes_by_prefix':</div>
          <div>bytes_by_prefix.c:193: error: 'B_MULT' undeclared (first
            use in this function)</div>
          <div>make[1]: *** [bytes_by_prefix.o] Error 1</div>
          <div>
            make[1]: Leaving directory
            `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'</div>
          <div>make: *** [lib-all] Error 2</div>
          <div><br>
          </div>
          <div>Can anybody please suggest some pointer so that we can go
            forward.&nbsp;</div>
          <div><br>
          </div>
          <div>Regards</div>
          <div>vikas bisla</div>
        </font></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. <a class="moz-txt-link-freetext" href="http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/">http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040901050302060201090901--


--===============7432358128935804650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============7432358128935804650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7432358128935804650==--

