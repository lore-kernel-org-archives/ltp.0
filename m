Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1T1gRn-0001Su-AU
	for ltp-list@lists.sourceforge.net; Wed, 15 Aug 2012 16:27:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T1gRm-0007tl-Em
	for ltp-list@lists.sourceforge.net; Wed, 15 Aug 2012 16:27:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 15 Aug 2012 12:27:47 -0400
References: <4505db854dcfba3131523a89e158cae4f9c27d01.1345025497.git.jstancek@redhat.com>
In-Reply-To: <4505db854dcfba3131523a89e158cae4f9c27d01.1345025497.git.jstancek@redhat.com>
MIME-Version: 1.0
Message-Id: <201208151227.48778.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] ioctl: check if tty device nodes are usable
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1066278779899755069=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1066278779899755069==
Content-Type: multipart/signed; boundary="nextPart19516831.PCsE3e53T3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart19516831.PCsE3e53T3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 15 August 2012 06:14:34 Jan Stancek wrote:
> +has_tty()
> +{
> +    if command -v stty >/dev/null 2>&1; then
> +        stty --file=$1 > /dev/null
> +        if [ $? -ne 0 ]; then
> +            return 0;
> +        fi
> +    fi
> +    return 1;

no need for the trailing semi colons on either of those return statements

> +        continue;

or here

> +        continue;

or here
-mike

--nextPart19516831.PCsE3e53T3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQK84EAAoJEEFjO5/oN/WBdloP/2lz0EnB9uR+yi+G/VOC2RM2
jhJ8Rc4FKy+Mak4NLXOFrVbj0NGX7Ygg/LBIUpYJHHjvTVaACRUtGmvR/IyvHcAW
sc1wnq/2NWgqHwpYWqOWg2CFwMJTy9CPzXJgHvCrBUQLhPAIQx3ELmWHDxJDV485
kasDVKNuvIH2KPXfzL54zEW1qK2OsEieTMGsbPI948umE4NkRRCQ6dT8grquWzWm
yZ2aJPRTWfcobxt1UARJe3VGKA5u3f79eLBcKGpT4XjbD9ciFzmocUig0uy9IhBg
taJGYcsafe1U2EKLQy2fSJNlopfMCBD2BX/rJvMk9FrUAAAsuLRe+tr0F6VHjGUh
zL7omfVNELFYT6HVdJzDPykcWQFJVG54S/Idf2ZwrX1C1/KqBDPWzoSj8Qq/3KX7
HClL1hVBCtVFpdHR65vApWj8gxNFwcrIBc+SFZhJi6tWskMMiiDP8IfOdL01JMY/
xhTm4LRkBBNixLappQLT20DZpUurPkEVih9P+LcNZE78aMHwZ8g8fGKThQ8KQBxO
45h30G/VSAANM02IqKimJGQKyAmC/LJ1D6DRCI8CmC4Pj/LeC386/4d01MDRj12O
9HhanXG5+xtq6+h1y5amHDgVmPBme2AEEMB1Q6Xg759MWtUXzcPlJs9iYl77IABf
D5j//aMynk2MEmMIFI+9
=ogh0
-----END PGP SIGNATURE-----

--nextPart19516831.PCsE3e53T3--


--===============1066278779899755069==
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
--===============1066278779899755069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1066278779899755069==--

