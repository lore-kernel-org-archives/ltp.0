From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Jan 2016 03:30:16 -0500 (EST)
Subject: [LTP] get_mempolicy failing to compile
In-Reply-To: <CANKSX+E608-qFt=-_vneFeBL+BH3zjZGsJXyjJ74rv3k507UYw@mail.gmail.com>
References: <CANKSX+ENW0PPUWmJ5EjOtCJX+4qGppBvw-uW4W6eEC3WRDiWrw@mail.gmail.com>
 <CANKSX+EYKTb9gRY_5OSZjj0JhzenjzE=9F4rN08uCHM10Nbz+Q@mail.gmail.com>
 <811903974.10514978.1453374406283.JavaMail.zimbra@redhat.com>
 <CANKSX+E228KPNQ7e20A8JDK3VY071AneN0ZNVxdiH3+uQUudkg@mail.gmail.com>
 <1328964111.10534362.1453378477201.JavaMail.zimbra@redhat.com>
 <CANKSX+HPL_+G4YWYtS0K7hesk36H+3D=endwvQmzTK1bGqSaYg@mail.gmail.com>
 <898714872.10545516.1453380405909.JavaMail.zimbra@redhat.com>
 <CANKSX+E608-qFt=-_vneFeBL+BH3zjZGsJXyjJ74rv3k507UYw@mail.gmail.com>
Message-ID: <13368452.10990988.1453451416635.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "$rik@nth" <srikanth007m@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Sent: Friday, 22 January, 2016 5:25:54 AM
> Subject: Re: [LTP] get_mempolicy failing to compile
> 
> My environment is ARM ubuntu and all my libs and packages are in AMR.

config.log you gave us is from x86_64 system named "hyd-lnxbld84".

> Yes able to compile the source  static as well
> linaro@linaro-alip:~/Srikanth$ gcc -static numatest.c -lnuma

This is a different system, isn't it?

What I meant was "hyd-lnxbld84" system and gcc you use to
compile LTP:
  arm-linux-gnueabihf-gcc -static numatest.c -lnuma
